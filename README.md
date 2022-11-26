# Larawind CLI

A bash cli for running laravel docker applications with blade rendered configurations.

### Install

Download/clone a tag release and make `larawind` file available on `$PATH` so that it maybe executed/found via `which larawind`, for example:

```bash
PATH=$PATH:/usr/local/bin/larawind-cli/larawind
```

## Dependencies

- bash
- docker
- find
- jq
- cut
- sha1sum
- tr

## Initialize Project

To create a `.larawind` directory within the root of your project, run `larawind init`. This is the workspace your template files will exist and where the cli will work in.

## Customize 

At this point you should customize `.larawind/variables.json` and `.larawind/templates` to liking.


## Template Variables & Rendering Templates

To render the project's configurations from the `.larawind/templates` directory, run `larawind render`. This will build a small php image and run an ephemeral container to render you templates in php with the laravel blade engine. If you dont plan to render often consider running with the `--remove-image` flag so that the image gets removed after it's done rendering. That said, this command will gather variable data in following in order from lowest to highest in terms of precedence:

- `.larawind/variables.json` : These are your base variables that are likely what you want to set with values for a local environment.
- `.larawind/state/variables.json` set from the `larawind set-variable` command. These variables overwrite `.larawind/variables.json` and maybe used in place of command line option variables so you dont have to remember to pass them during deployments/CI pipelines and maybe preferred when referencing variables in hook scripts since command line options cannot be passed to hook scripts. 
- Your project's `.env` file, loaded from the root of your project.
- Command line options when calling the render command, e.g `larawind render --app-env=local` (sets `$appEnv`).

In addition, some other useful computed variables will be injected at run time during `larawind render` call.

**Note** - Since command line options are kebab/slug cased, and that convention is not supported for php variable names, all variables are normalized to **camel** case.

**Note** - You may also inspect what variables will be available to you during rendering using the `--inspect-vars` option, i.e `larawind render --inspect-vars`. This will dump out the variable's with laravel's `dd` helper which is helpful for debugging purposes.
## Build Images

Once templates have been rendered, the dockerfiles in `.larawind/rendered/dockerfiles` named in this format (`<name>.<version>.Dockerfile`) will be built using `larawind build`

**Note** You may use any arbitrary options to pass to `docker build`, e.g `larawind build --no-cache`

**Note** Dockerfiles in `.larawind/templates/dockerfiles` are expected to be in this format: `<name>.<version>.Dockerfile`, this is so that image name variables can be conveniently injected during `larawind render`

## Services


When processing service files, the `.larawind/rendered/compose/base.yaml` and `.larawind/rendered/compose/<APP_ENV>.env.yaml` files first followed by ever other discovered yaml services file in `.larawind/rendered/compose` when calling commands related to starting/stopping services as documented below: 

### Start Services

Once images are built, you may start services with `larawind start`. 


### Stop Services & Containers

You may stop and remove service containers use `larawind stop`. 


### Hooks 

Hooks are a way to hook into before/after larawind command calls. Hook scripts can be placed an executable bash script at `.larawind/hooks` for any of the following script/hook events:

- `before_start` - Executed before `larawind start` peforms any tasks.
- `after_start` - Executed after `larawind start` peforms it's tasks.
- `before_nuke` - Executed before `larawind nuke` peforms any tasks.
- `after_nuke` - Executed after `larawind nuke` peforms it's tasks.

### Nuke 

During local development, it maybe useful to completely nuke all services, containers, & related resources, which may be done with `larawind nuke`


**Note** In non local envs, this will prompt for confirmation unless `--force` is passed. Use with caution.



### Contributing

- Make a branch with your changes, use `./watch` as you actively develop so the cli can be regenerated with [Bashly](https://bashly.dannyb.co/)
- Submit Pull Request