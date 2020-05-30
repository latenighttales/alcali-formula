# Alcali formula

[![Build Status](https://travis-ci.org/latenighttales/alcali-formula.svg?branch=master)](https://travis-ci.org/latenighttales/alcali-formula)


<img align="right" height="300" src="https://upload.wikimedia.org/wikipedia/commons/5/5f/Logo_du_Mois_de_la_contribution_sans_texte.svg">

A SaltStack formula to install and configure [Alcali](https://github.com/latenighttales/alcali).

 Alcali is a web based tool for monitoring and administrating **Saltstack** Salt.


## Available states

- [alcali](#alcali)
- [alcali.user](#alcaliuser)
- [alcali.package](#alcalipackage)
- [alcali.config](#alcaliconfig)
- [alcali.service](#alcaliservice)
- [alcali.clean](#alcaliclean)
- [alcali.user.clean](#alcaliuserclean)
- [alcali.package.clean](#alcalipackageclean)
- [alcali.config.clean](#alcaliconfigclean)
- [alcali.service.clean](#alcaliserviceclean)

## Testing

[Requirements](#requirements)

- [bin/kitchen converge](#binkitchen-converge)
- [bin/kitchen verify](#binkitchen-verify)
- [bin/kitchen destroy](#binkitchen-destroy)
- [bin/kitchen test](#binkitchen-test)
- [bin/kitchen login](#binkitchen-login)


### Alcali

_Meta-state (This is a state that includes other states)._

This create the alcali user, installs the alcali package, manages the alcali configuration file and then starts the associated alcali service.

### alcali.user
This state will create the alcali user only.

### alcali.package
This state will install the alcali package only.

### alcali.config
This state will configure the alcali service and has a dependency on alcali.install via include list.

### alcali.service
This state will start the alcali service and has a dependency on alcali.config via include list.

### alcali.clean
_Meta-state (This is a state that includes other states)._

this state will undo everything performed in the alcali meta-state in reverse order, i.e. stops the service, removes the configuration file, uninstalls the package and remove the user.

### alcali.user.clean
This state will remove the alcali user.

### alcali.service.clean
This state will stop the alcali service and disable it at boot time.

### alcali.config.clean
This state will remove the configuration of the alcali service and has a dependency on alcali.service.clean via include list.

### alcali.package.clean
This state will remove the alcali package and has a dependency on alcali.config.clean via include list.

## Testing

Linux testing is done with kitchen-salt.

### Requirements

- Ruby
- Docker

```commandline
$ gem install bundler
$ bundle install
$ bin/kitchen test [platform]
```

Where [platform] is the platform name defined in kitchen.yml, e.g. debian-9-2019-2-py3.

### bin/kitchen converge

Creates the docker instance and runs the template main state, ready for testing.

### bin/kitchen verify

Runs the inspec tests on the actual instance.

### bin/kitchen destroy

Removes the docker instance.

### bin/kitchen test

Runs all of the stages above in one go: i.e. destroy + converge + verify + destroy.

### bin/kitchen login

Gives you SSH access to the instance for manual testing.

#### TODO:

- Add multiple install options.

## Contribute

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

If you like this project, consider donating:

via GitHub Sponsors, or

[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/J3J3173F6)


<sub><sub>Image: Jean-Philippe WMFr, derivative work : User:Benoit Rochon [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0)</sub></sub>
