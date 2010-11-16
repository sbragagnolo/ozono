Class {
	#name : #ObjectBrowserTextMorphForEditView,
	#superclass : #TextMorphForEditView,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectBrowserTextMorphForEditView >> editorClass [
	"Answer the class used to create the receiver's editor"
	
	^ObjectBrowserTextMorphEditor
]
