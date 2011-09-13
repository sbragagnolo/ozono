Class {
	#name : #ObjectBrowserTextMorphEditor,
	#superclass : #TextEditor,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectBrowserTextMorphEditor >> editorClass [
	^ObjectBrowserTextMorphEditor
]

{ #category : #'as yet unclassified' }
ObjectBrowserTextMorphEditor >> errorHandler [
	^ErrorHandler default
]

{ #category : #'as yet unclassified' }
ObjectBrowserTextMorphEditor >> evaluateSelection [
	self errorHandler
		evaluate: [^super evaluateSelection]
]

{ #category : #'as yet unclassified' }
ObjectBrowserTextMorphEditor >> textMorphEditorClass [
	^ObjectBrowserTextMorphEditor
]
