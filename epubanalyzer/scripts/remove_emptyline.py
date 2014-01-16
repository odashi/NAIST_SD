# coding: utf-8

import codecs
import sys

with \
	codecs.open(sys.argv[1], 'r', 'utf-8') as fi, \
	codecs.open(sys.argv[2], 'w', 'utf-8') as fo:
	for l in fi:
		ll = l.strip()
		if ll:
			fo.write(ll+'\n')
	

