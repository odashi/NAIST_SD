# coding: utf-8

import codecs
import sys
import html.parser as hp
import xml.sax.saxutils as su

class MyHTMLParser(hp.HTMLParser):

	def __init__(self, fs):
		hp.HTMLParser.__init__(self)
		self.__no = 0
		self.__in_body = False
		self.__fs = fs

	def handle_starttag(self, tag, attrs):
		if tag == 'body':
			self.__in_body = True
		attrstr = ' '.join('%s=%s' % (a[0], su.quoteattr(a[1])) for a in attrs)
		if attrstr:
			print('<%s %s>' % (tag, attrstr))
		else:
			print('<%s>' % tag)
		
	def handle_endtag(self, tag):
		if tag == 'body':
			self.__in_body = False
		print('</%s>' % tag)

	def handle_data(self, data):
		stripped = data.strip()
		if not stripped:
			return
		if self.__in_body:
			while True:
				sent = next(self.__fs).strip()
				if not sent:
					break
				print('<span id="SENTENCE_%d">' % self.__no + su.escape(sent) + '</span>')
				self.__no += 1
		else:
			print(su.escape(stripped))

with \
	codecs.open(sys.argv[1], 'r', 'utf-8') as fp,\
	codecs.open(sys.argv[1]+'.sent.split', 'r', 'utf-8') as fs:
	parser = MyHTMLParser(fs)
	data = fp.read()
	parser.feed(data)

