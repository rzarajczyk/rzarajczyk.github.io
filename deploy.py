import re
import textwrap
import os

REGEX = re.compile(r"<!--LISTING\(([^)]+).*END LISTING-->", flags=re.DOTALL)


def get_lang(path):
    _, extension = os.path.splitext(path)
    if extension == '.sh':
        return 'shell'
    return 'text'


def update_code_block(match):
    referenced_filename = match.group(1)
    lang = 'shell'
    with open(referenced_filename, 'r') as f:
        referenced_content = f.read()
    result = f"""<!--LISTING({referenced_filename})-->
[download]({referenced_filename})
```{lang}
{referenced_content}
```
<!--END LISTING-->"""
    return textwrap.dedent(result)


with open('macos-memory-statistics.md', 'r') as f:
    content = f.read()
replaced_content = re.sub(REGEX, update_code_block, content)
if content != replaced_content:
    with open('macos-memory-statistics.md', 'w') as f:
        f.write(replaced_content)
