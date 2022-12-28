#!/bin/bash
FILEPATH=~/Library/KeyBindings/DefaultKeyBinding.dict
if [ -f $FILEPATH ]; then
  echo "File $FILEPATH already exists" && exit 1
fi
if [[ $SHELL != '/bin/zsh' ]]; then
  echo "Please set ZSH as your default shell" && exit 1
fi

mkdir -p ~/Library/KeyBindings
tee $FILEPATH << EOM
{
  "\UF729"  = moveToBeginningOfParagraph:; // home
  "\UF72B"  = moveToEndOfParagraph:; // end
  "$\UF729" = moveToBeginningOfParagraphAndModifySelection:; // shift-home
  "$\UF72B" = moveToEndOfParagraphAndModifySelection:; // shift-end
  "^\UF729" = moveToBeginningOfDocument:; // ctrl-home
  "^\UF72B" = moveToEndOfDocument:; // ctrl-end
  "^$\UF729" = moveToBeginningOfDocumentAndModifySelection:; // ctrl-shift-home
  "^$\UF72B" = moveToEndOfDocumentAndModifySelection:; // ctrl-shift-end
}
EOM

## Additional steps for iTerm2
echo "bindkey '\e[H'    beginning-of-line" >> ~/.zshrc
echo "bindkey '\e[F'    end-of-line" >> ~/.zshrc

echo "Done, please reboot the system"
