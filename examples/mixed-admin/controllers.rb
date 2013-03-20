module Admin
  class Reports < E
    include Rear
    label :Reports

    def index
      # will render view/admin/reports/index.slim within Rear's layout
      reander
    end
  end
end
