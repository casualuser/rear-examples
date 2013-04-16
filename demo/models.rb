# Accounts
class Account < ActiveRecord::Base
  belongs_to :supplier
  has_one :account_history

  begin # Rear setup
    include Rear

    # using custom label for menu
    label :Accounts

    # displaying date in human format on pane pages.
    # `pane_value` accepts a block that is executed
    # in context of running controller(read access to `params` etc.)
    # and have access to current item via `item` method.
    # use `editor_value` to pre-process loaded data before displaying on editor page
    input :created_at do
      pane_value { item.created_at ? item.created_at.strftime('%b %e, %Y') : '' }
    end

    # search accounts by name
    filter :name

    # search accounts by creation date.
    # no need to set filter type, it will be automatically inherited from ORM setup
    filter :created_at

    # sort fetched items by creation date in descending mode
    order_by 'created_at DESC'

    # account_history is of no interest for now,
    # so using `ignored_assoc` to hide it from Rear interface.
    # it will still work as expected, just not shown when editing accounts.
    ignored_assoc :account_history
  end
  
end

class AccountHistory < ActiveRecord::Base
  belongs_to :account
end

class Supplier < ActiveRecord::Base
  # though we do not include Rear here,
  # Rear will automatically handle this model
  # so when editing accounts we will can select supplier
  
  has_one :account
  has_one :account_history, through: :account
end


# Articles
class Article < ActiveRecord::Base
  has_and_belongs_to_many :categories, join_table: :article_categories

  begin # Rear setup
    include Rear

    # `under` is a sugar alias for `menu_group`.
    # used to put multiple controllers under same menu entry
    # that will reveal controller links on hover.
    under :Articles

    # adding some CSS classes when rendering name element on pane pages.
    # `pane_attrs` is for adding HTML attributes to the elements rendered on pane pages.
    # use `editor_attrs` to add attrs used only on editor pages.
    # use `attrs`(or `html_attrs`) to add attrs used on either page.
    # to add attrs used by any column, use same methods outside input block.
    input :name do
      pane_attrs scope: :pane, class: 'label label-info'
    end

    # using :ckeditor type to edit text in CKEditor rather than in textarea.
    # setting :pane to false to hide column on pane pages.
    input :content, :ckeditor, pane: false do
      # using `public_path` to enable a file browser
      # that will allow to insert images/videos into editor.
      # also it will allow to upload/delete images and video files.
      public_path File.expand_path('../public/images', __FILE__)

      # snippets passed here will be displayed into a dialog(after clicking snippets button)
      # and ready for insertion into editor. 
      snippets '#{ s "top-menu" }', '#{ s "left-menu" }', '#{ s "banners" }'
    end

    # search articles by name
    filter :name

    # search articles by category
    assoc_filter :categories

    # adding a decorative column that will display article categories.
    # `editor: false` will disable column on editor page.
    input :Categories, editor: false do
      pane_value { item.categories.map {|c| c[:name]}.join(', ') }
    end

    # display 20 articles per page
    items_per_page 20
  end
  
end

class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles, join_table: :article_categories

  begin # Rear setup
    include Rear
    under :Articles

    # show only category name when categories are displayed on article's editor,
    # that's it, when editing an article and are going to select a category,
    # we want to see only the name of category.
    assoc_columns :name

    # adding some CSS classes to all columns rendered on pane pages.
    # to add attrs to specific column(s), use `pane_attrs` inside input block.
    pane_attrs class: 'thumbnail'
  end

end


# Locations
class City < ActiveRecord::Base
  belongs_to :state, foreign_key: :state_code, primary_key: :code

  begin # Rear setup
    include Rear
    under :Locations

    # we need url to be editable only when new city created.
    # user should not be able to update url of existing cities.
    # this is achieved by setting :readonly option to true
    input :url, readonly: true

    # search cities by name
    filter :name
  end

end

class State < ActiveRecord::Base
  has_many :cities, foreign_key: :state_code, primary_key: :code

  begin # Rear setup
    include Rear
    under :Locations

    # the cities<=>states relation should be editable only by cities,
    # so using `readonly_assoc` to prohibit States from attaching cities.
    readonly_assoc :cities

    # :code is a immutable column, so disabling it by setting :disabled option to true.
    # disabled columns are excluded from data sent to ORM.
    # also, unlike readonly columns, disabled columns wont be editable
    # when new items created
    input :code, disabled: true
  end

end


# Persons
class Person < ActiveRecord::Base
  has_one :profile

  begin # Rear setup
    include Rear
    under :Persons

    # `row` method allow to put multiple columns on same row
    row do
      # using label option to set custom labels for :name_first and :name_last
      input :name_first, label: 'First Name'
      input :name_last,  label: 'Last Name'
    end

    # increase position to show it first in top menu.
    # no controllers with position higher than 1000, so this will go first.
    position 1000
  end
  
end

class Profile < ActiveRecord::Base
  belongs_to :person

  begin # Rear setup
    include Rear
    under :Persons
  end

end


# Photos
class Photo < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  begin # Rear setup
    include Rear
    under :Photos

    # show Photos immediately after Persons in top menu,
    # that's it, Person's position is 1000
    # and no controllers with position between 1000 and 900,
    # so Persons will go first and Photos will go second.
    position 900

    # turn gamma column into a checkbox input.
    # gamma column is a coma-separated list of values kept as a String in database,
    # thus we need to split it accordingly for checkboxes to be checked properly.
    # so using `options` method to pass a list of options
    # and a block that will split saved string into array
    input :gamma, :checkbox do
      options("Red", "Green", "Blue") { item.gamma.to_s.split(',') }
    end

    # when saving a photo, gamma input will send an array to ORM.
    # that's a normal behavior for checkboxes and multi-select inputs to send an array.
    # and we need somehow to convert that array into a string.
    # Rear allow to define `on_save`, `on_update` and `on_destroy` hooks,
    # so using `on_save` hook to convert gamma array into a string before sending it to ORM.
    on_save do
      params[:gamma] = params[:gamma].join(',') if params[:gamma].is_a?(Array)
    end

    # `quick_filter` will render a button for each given option
    # and will filter items by the value of clicked button.
    # in this example it will render 3 buttons - Red, Green and Blue
    # and will return photos with gamma=Red when Red clicked. same for Green and Blue
    quick_filter :gamma, "Red", "Green", "Blue"
  end

end

class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :photos, through: :taggings

  begin # Rear setup
    include Rear
    under :Photos
  end

end

class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :photo
end

# Tasks
class Task < ActiveRecord::Base
  belongs_to :worker

  begin # Rear setup
    include Rear
    under :Tasks

    # priority are kept in db as integers and will be rendered as a text input.
    # to render a radio input instead, using `input` with second argument set to :radio
    # and a block that defines options to be used by radio input.
    # `options` method accepts an Array or a Hash.
    # Array are used when keys and values are the same.
    # Hash  are used when keys stored in db differs from rendered labels.
    input :priority, :radio do
      options 0 => 'Low', 5 => 'Medium', 10 => 'High', 15 => 'Critical'
    end
  end
  
end

class Worker < ActiveRecord::Base
  has_many :tasks

  begin # Rear setup
    include Rear
    under :Tasks

    # enforcing readonly mode for Worker model.
    # in readonly mode no new items can be created nor existing updated/deleted.
    # also all associations will be in readonly mode,
    # meant attaching/detaching related items will be prohibited
    readonly!

    # using a select input to allow user to select from predefined options.
    # using an Array for options cause stored and rendered values are the same.
    # also using :row option to render it on same row with name
    input :load, :select, row: :Generic do
      options 'Low', 'Medium', 'High', 'Heavy'
    end

    # using :row option to render it on same row with load
    input :name, row: :Generic
  end
  
end
