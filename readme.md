<div align="center" class="documentation-header">
    <img width="100" alt="LesliTesting logo" src="./docs/images/termline-logo.svg" />
    <h3 align="center">Human-friendly terminal logs for the Lesli Platform</h3>
</div>

<br />
<hr/>
<br />


### Quick start

```shell
# Add LesliAdmin engine gem
bundle add termline
```

### Usage 
```ruby
Termline.msg "Hello world"
Termline.info "Server started"
Termline.success "All tests passed"
Termline.warning "Low disk space"
Termline.danger "Something failed"

Termline.br

Termline.table([
  { name: "Luis", role: "Admin", status: "Active" },
  { name: "Ana", role: "Developer", status: "Pending" }
])
```

**Result:** 

<img  alt="LesliTesting logo" src="./docs/images/screenshot.png" />


### Documentation
* [website](https://www.lesli.dev/)
* [documentation](https://www.lesli.dev/gems/termline/)


### Connect with Lesli

* [X: @LesliTech](https://x.com/LesliTech)
* [Email: hello@lesli.tech](hello@lesli.tech)
* [Website: https://www.lesli.tech](https://www.lesli.tech)


### License
-------
Copyright (c) 2026, Lesli Technologies, S. A.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see http://www.gnu.org/licenses/.

<br />
<hr />
<br />
<br />

<div align="center" class="has-text-centered">
    <img width="200" alt="Lesli logo" src="https://cdn.lesli.tech/lesli/brand/app-logo.svg" />
    <h3 align="center" class="mt-0">
        The Open-Source SaaS Development Framework for Ruby on Rails.
    </h3>
</div>

<br />
<br />
