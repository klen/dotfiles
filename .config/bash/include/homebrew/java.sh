if [[ -d /opt/homebrew/opt/openjdk ]]
then
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
  export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
  # export JAVA_HOME="$(/opt/homebrew/bin/brew --prefix openjdk)/libexec/openjdk.jdk/Contents/Home"
fi

if [[ -d /opt/homebrew/opt/openjdk@11 ]]
then
  export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
  export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"
  # export JAVA_HOME="$(/opt/homebrew/bin/brew --prefix openjdk)/libexec/openjdk.jdk/Contents/Home"
fi

