import sys

from translate import Translator
translator= Translator(to_lang="Korean")

read_file=sys.argv[1]

f = open(read_file, 'r')
while True:
    line = f.readline()
    if not line: break
    print(line)
    translation = translator.translate(line)
    print (translation)
f.close()

print ("Cloud Translation API 의 할당량 및 제한 https://stackoverflow.com/questions/54149160/maximum-string-size-to-be-translated-by-google-api")
