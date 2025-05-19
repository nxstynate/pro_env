function HelloWorld {
    param ([string]$name)
    $greeting = 'hello world'
    echo "$greeting $name"
  }
  HelloWorld('Nate')
