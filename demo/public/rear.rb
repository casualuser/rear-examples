module Rear
  class << self
    NODES = []

    def included base
      if (cm = (base.methods & RearSetupYielder.public_instance_methods(false))).any?
        puts '--- Conflicting Methods Detected! ---'
        puts 'Following methods contained in both %s class and RearSetup module: %s' % [base, cm*', ']
        puts
        raise ArgumentError
      end
      base.extend RearSetupYielder
      
      if RearUtils.is_orm?(base)
        base.model base
        ctrl = RearUtils.initialize_model_controller(base)
        NODES << [base, ctrl]
      elsif EUtils.is_app?(base)
        NODES << [base, base]
      else
        raise ArgumentError, '%s is not a ActiveRecord/DataMapper model nor a Espresso controller' % base
      end
    end

    def controllers
      @controllers ||= begin
        controllers = []

        NODES.each do |(base,ctrl)|
          base == ctrl ? RearUtils.prepare_controller(base) : RearUtils.prepare_model_controller(base)
          base.__rear__setups.each do |(meth,args,proc)|
            ctrl.send meth, *args, &proc
          end
          base.__rear__setups.clear.freeze
          controllers << ctrl
        end
        controllers.uniq.each do |ctrl|
          ctrl.model && ctrl.assocs.each_value do |assocs|
            assocs.each_value do |assoc|
              if remote_model = assoc[:remote_model]
                controllers << RearUtils.associated_model_controller(remote_model)
              end
            end
          end
        end
        controllers.unshift RearHomeController

        NODES.clear.freeze
        controllers.uniq!
        controllers
      end
    end

    def menu
      @menu ||= begin
        containers  = {}
        controllers = Rear.controllers.reject {|c| c == RearHomeController}.
          select {|c| c.label}.inject({}) do |f,c|
            c.menu_group? ?
              ((containers[c.menu_group] ||= []).push(c); f) : f.merge(c=>[c])
        end
        controllers.merge(containers).sort do |a,b|
          b.last.inject(0) {|t,c| t += c.position} <=> a.last.inject(0) {|t,c| t += c.position}
        end
      end
    end

    def app
      @app ||= E.new.mount(controllers)
    end
    alias to_app app
    alias mount! app

    def call env
      app.call env
    end

    def run *args
      app.run *args
    end

  end
end  
