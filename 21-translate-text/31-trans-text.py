# def read_txt (filename, sep='') :
# 출처: https://data-make.tistory.com/109 [Data Makes Our Future]

import googletrans
translator = googletrans.Translator()

filename="/home/yos/31-markdown-files/packtpub/flutter4beginners2/flutter4beginners2_103.md"

def read_txt (filename):
	# print (f"filename = {filename}")
	str = ''
	file = open (filename,'r')
	# print (f"str = file.readlines ()")
	str = file.readlines ()

	for aline_en in str :
		if len(aline_en) < 2:
			# print (f"{aline_en}")
			print (f"")
		else:
			aline_ko=translator.translate (aline_en, dest='ko')
			print (f"{aline_en}{aline_ko.text}")

	file.close()

read_txt (filename)
