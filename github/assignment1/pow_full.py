#! /usr/bin/env python3

def powI(power, base):
	acc = 1
	for p in range(power):
		acc *= base

	return acc

def powF(power, base):
	if power <= 0:
		return 1

	return base * powF(power - 1, base)