# coding: utf-8

import sys
import glob
from html.parser import HTMLParser
import xml.sax.saxutils as su


def toks(s):
	i = 0
	while i < len(s):
		if s[i] in ['(', ')']:
			yield s[i]
			i += 1
		elif s[i] == ' ':
			i += 1
		else:
			elm = ''
			while s[i] not in ['(', ')', ' ']:
				elm += s[i]
				i += 1
			yield elm

def convtok(tok):
	return ''.join((w if w.isalnum() else '_') for w in tok)

def makespan(s):
	if len(s) == 0:
		return ''

	ret = ''
	stack = []
	tokgen = toks(s)
	
	while True:
		t = next(tokgen)
		if t == '(':
			if stack and stack[-1] != '(':
				# syntax
				ret  += '<span class="syntax %s">' % convtok(stack[-1])
				stack.pop() # pop SYNTAX
			stack.append(t)
		elif t == ')':
			ret += '</span>'
			stack.pop() # pop '('
		else:
			if stack and stack[-1] == '(':
				stack.append(t)
			else:
				# word
				ret += ' <span class="word %s">%s' % (convtok(stack[-1]), t)
				stack.pop() # pop POS

		if not stack:
			break

	return ret


class MyHTMLParser(HTMLParser):
	def __init__(self, spandata):
		HTMLParser.__init__(self)
		self.__spandata = spandata
		self.__output = ''
		self.__in_sent = False
		self.__j = 0

	def handle_starttag(self, tag, attrs):
		attrstr = ' '.join('%s=%s' % (a[0], su.quoteattr(a[1])) for a in attrs)
		if attrstr:
			self.__output += '<%s %s>' % (tag, attrstr)
		else:
			self.__output += '<%s>' % tag
		for attr in attrs:
			if attr[0] == 'id' and attr[1][:9] == 'SENTENCE_':
				self.__in_sent = True

	def handle_endtag(self, tag):
		self.__output += '</%s>' % tag
		self.__in_sent = False

	def handle_data(self, data):
		if self.__in_sent:
			self.__output += self.__spandata[self.__j]
			self.__j += 1
		else:
			self.__output += data
	
	def get(self):
		return self.__output

def main():
	spandata = []
	with open(sys.argv[3], 'r', encoding='utf-8') as fp:
		for l in fp:
			spandata.append(makespan(l.strip()))
	with open(sys.argv[2], 'r', encoding='utf-8') as fp:
		data = fp.read()
	parser = MyHTMLParser(spandata)
	parser.feed(data)
	with open(sys.argv[1], 'w', encoding='utf-8') as fp:
		fp.write(parser.get())
		
if __name__ == '__main__':
	main()

