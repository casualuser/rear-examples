
With autopilot version you do not need to build controllers manually.

You just `include Rear` in your models and `mount Rear.controllers` in your application.

To run these applications you need a database server running and the ability to create a database or to import data into existing one.

To get started please edit `boot.rb` inside each application by inserting your connection details.

To not mangling with migrations you can just import "schema.sql" from "assets/" folder at the top of this repository.
