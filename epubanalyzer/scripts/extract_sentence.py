# coding: utf-8

import codecs
import sys
import html.parser as hp
import xml.sax.saxutils as su

class MyHTMLParser(hp.HTMLParser):

	def __init__(self):
		hp.HTMLParser.__init__(self)
		self.__in_body = False

	def handle_starttag(self, tag, attrs):
		if tag == 'body':
			self.__in_body = True
		
	def handle_endtag(self, tag):
		if tag == 'body':
			self.__in_body = False

	def handle_data(self, data):
		stripped = data.strip()
		if not stripped:
			return
		if not self.__in_body:
			return
		print(stripped+'\n')

with codecs.open(sys.argv[1], 'r', 'utf-8') as fp:
	parser = MyHTMLParser()
	data = fp.read()
	parser.feed(data)

