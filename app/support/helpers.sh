## remove trailing character.
remove_trailing() {
    value="$1"
    char="$2"
    echo ${value%"$char"}
}
## remove leading character.
remove_leading() {
    value="$1"
    char="$2"
    echo ${value#"$char"}
}

## get the string content after the given substring.
str_after(){
    value="$1"
    substring="$2"
    echo ${value##*$substring}
}
## get the string content before the given substring.
str_before(){
    value="$1"
    substring="$2"
    echo ${value%$substring*}
}

## genearate a path relative to the project .larawind dir.
larawind_path() {
    path="${1:-/}"
    base="$(pwd)/.larawind"
    path=$(remove_leading "$path" "/")
    path=$(remove_trailing "$path" "/")
    path="$base/$path"
    echo $(remove_trailing "$path" "/")
}

## generate a path relative to the root of the cli directory.
larawind_cli_path() {
    path="${1:-/}"
    base="$LARAWIND_CLI_PATH"
    path=$(remove_leading "$path" "/")
    path=$(remove_trailing "$path" "/")
    path="$base/$path"
    echo $(remove_trailing "$path" "/")
}

## check if a docker image exists locally.
docker_image_exists() {
  if  [ ! -z "$(docker images -q $1)" ]
  then
    true
  else
    false
  fi
}

## append a key value to a json string using jq.
insert_json(){
    echo "$(jq -n --arg data "$1" --arg key "$2" --arg value "$3" '$data | fromjson + { ($key) : ($value) }')"
}

## run a .larwind hook if executable and present.
run_hook(){
    if [ -f ".larawind/hooks/$1" ] && [ -x ".larawind/hooks/$1" ];
    then
        info "Executing hook: $1"
            
        . .larawind/hooks/$1
    fi
}

## get a variable value from state or base variables.json files:
get_variable(){
    var="null"
    if [ -f $(larawind_path state/variables.json) ]
    then
        value=$(jq -r .$1 $(larawind_path state/variables.json))
        if [ $value == "null" ]
        then
            value=$(jq -r .$1 $(larawind_path variables.json))
        fi
    else
        value=$(jq -r .$1 $(larawind_path variables.json))
    fi
    echo $value
    
}

## get the previous build json state file.
get_build_hash_file(){
    build_state_hash_filepath=$(larawind_path state/build-sums.json)

    if [ -f $build_state_hash_filepath ];
    then
        previous_hash_json="$(jq . $build_state_hash_filepath)"
    else
        previous_hash_json="{}"
    fi

    echo "$previous_hash_json"
}

## get the state set vars file.
get_set_variables_file(){
    variable_state_file=$(larawind_path state/variables.json)
    
    [ -f $variable_state_file ] || echo "{}" > $variable_state_file

    if [ -f $variable_state_file ];
    then
        vars_json="$(jq . $variable_state_file)"
    else
        vars_json="{}"
    fi

    echo "$vars_json"
}

