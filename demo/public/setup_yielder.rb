# classes extending this module will have all methods available in RearSetup.
# calling a method wont run it, instead it will store args and proc for later use.
# later we extending RearSetup on base class,
# and this will override &quot;yielding&quot; methods with real ones.
# then we simply calling real methods with stored args/procs.
# doing this mangling cause real methods should run only after app fully booted
# and ready to start, e.g. all models and controllers loaded.

module RearSetupYielder

  def __rear__setups
    @__rear__setups ||= []
  end

  RearSetup.public_instance_methods(false).each do |method_name|
    define_method method_name do |*args,&amp;proc|
      __rear__setups &lt;&lt; [method_name, args, proc]
    end
  end
end
