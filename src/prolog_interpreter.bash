prolog_interpreter() {
  xargs -0 -I{} swipl -t '{}' 2>/dev/null
}
