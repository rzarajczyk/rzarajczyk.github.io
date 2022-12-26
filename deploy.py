import re
import glob
import os

REGEX = re.compile(r"<!--LISTING\(([^)]+).*?END LISTING-->", flags=re.DOTALL)


def get_lang(path):
    _, extension = os.path.splitext(path)
    if extension == '.sh':
        return 'shell'
    return 'text'


def update_code_block(match):
    referenced_filename = match.group(1)
    print(f'    > Replacing listing of {referenced_filename}')
    lang = 'shell'
    with open(referenced_filename, 'r') as f:
        referenced_content = f.read()
    return f"""<!--LISTING({referenced_filename})-->
[⬇️ download]({referenced_filename})
```{lang}
{referenced_content}
```
<!--END LISTING-->"""


for file in glob.glob('*.md'):
    print(f'Processing {file}')
    with open(file, 'r') as f:
        content = f.read()
    replaced_content = re.sub(REGEX, update_code_block, content)
    if content != replaced_content:
        with open(file, 'w') as f:
            f.write(replaced_content)
