# check if function exists and define empty one if doesn't
if [[ $(type -t "__vte_prompt_command") != function ]]; then
    function __vte_prompt_command(){
        return 0
    }
fi
