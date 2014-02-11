Class {
	#name : #OBLabelReplacer,
	#superclass : #Object,
	#instVars : [
		'values',
		'expr'
	],
	#category : #'ObjectBrowser-PDFGeneration'
}

{ #category : #utils }
OBLabelReplacer >> allTextElements: pdfDoc [
	^ pdfDoc pages
		flatCollect: [ :page | page elements select: [ :e | (e class canPerform: #text) and: [ e class canPerform: #text: ] ] ]
]

{ #category : #accessing }
OBLabelReplacer >> at: key put: value. [
	values at: key put:value.
]

{ #category : #initialization }
OBLabelReplacer >> initialize [
	super initialize.
	values := Dictionary new.
	expr :=  '\*#(\w*)#\*' asRegex.
]

{ #category : #replacing }
OBLabelReplacer >> processElement: anElement [
	| key |
	anElement
		text:
			(expr
				copy: anElement text
				translatingMatchesUsing: [ :m | 
					key := expr subexpression: 2.
					(values at: key ifAbsent: [ m ]) asString ])
]

{ #category : #replacing }
OBLabelReplacer >> replaceAll:pdfDoc. [
	(self allTextElements: pdfDoc) do:[ :e | self processElement:e].
]
