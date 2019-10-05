# Alcali formula

<img align="right" height="300" src="https://upload.wikimedia.org/wikipedia/commons/5/5f/Logo_du_Mois_de_la_contribution_sans_texte.svg">

A SaltStack formula to install and configure [Alcali](https://github.com/latenighttales/alcali).

 Alcali is a web based tool for monitoring and administrating **Saltstack** Salt.


**Available states**

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


#### TODO:

- Add multiple install options.

- Add tests.



<sub><sub>Image: Jean-Philippe WMFr, derivative work : User:Benoit Rochon [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0)</sub></sub>
