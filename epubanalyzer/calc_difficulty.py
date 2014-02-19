# coding: utf-8

# usage: pyhon calcdifficulty.py <path: directory of EPUB data> <path: word count table>

import math
import os
import sys
from collections import defaultdict

def loadidf():
	table = []
	total = 0
	wc = 0
	with open(sys.argv[2], encoding='utf-8') as fp:
		for l in fp:
			# ls = l.split('\n')[0].split('\t')
			ls = l[:-1].split('\t')
			x = (ls[0].lower(), int(ls[1])+1)
			table.append(x)
			total += x[1]

	log_total = math.log(total)
	idf = defaultdict(lambda: log_total)
	for k, v in table:
		idf[k] = log_total - math.log(v)
	
	return idf

def main():
	idf = loadidf()

	total_score = 0.0
	total_wc = 0
	for path, dirs, files in os.walk(sys.argv[1]):
		for fname in files:
			if fname[-4:] == '.tok':
				score = 0.0
				wc = 0.0
				with open(path+'/'+fname, encoding='utf-8') as fp:
					for l in fp:
						for w in l.split():
							score += idf[w]
							wc += 1
				print('score=%f, #word=%d (%s)' % (score/wc, wc, path+'/'+fname))
				total_score += score
				total_wc += wc
	print('total-score=%f, total-#word=%d' % (total_score/total_wc, total_wc))

if __name__ == '__main__':
	main()

