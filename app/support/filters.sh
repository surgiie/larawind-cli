## check that docker is running.
filter_docker_running() {
    docker info >/dev/null 2>&1 || echo "Docker must be running"
}

## check that we are in a laravel project root.
filter_is_laravel_root() {
    if [ ! -f 'composer.json' ] || ! grep -q "laravel/framework" "composer.json"; then
        echo "$(error "Current directory is not a laravel/framework context.")"
    fi
}

## check the .env file exists
filter_has_env_file() {
    if [ ! -f '.env' ]; then
        echo "$(error "The project .env file is missing.")"
    fi
}

## check the .larawind folder is initialized
filter_project_is_initialized() {
    project_larawind_path="$(larawind_path)"

    if [ ! -d "$project_larawind_path" ] || [ -z "$(ls -A $project_larawind_path)" ]; then
        warning "The project .larawind directory does not appear initialized. Did you run 'larawind init'?"
    fi
}

## check the templates have been rendered.
filter_templates_are_rendered() {
    rendered_path="$(larawind_path rendered)"
    if [ ! -d "$rendered_path" ] || [ -z "$(ls -A $rendered_path)" ]; then
        warning "Templates have not been rendered to .larawind/rendered"
    fi
}
