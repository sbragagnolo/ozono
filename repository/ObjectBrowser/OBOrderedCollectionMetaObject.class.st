"
I am the meta-object that represents an (sub)instance of ordered collection.

I provide reflective access to the object to treat it as it is inside a prototipical system:

- attributes (instance variables)
- methods
- cloning

I also provide some information of the actions that can be performed on me that is for usage of the UI.
"
Class {
	#name : #OBOrderedCollectionMetaObject,
	#superclass : #OBCollectionMetaObject,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #methods }
OBOrderedCollectionMetaObject >> classSelectorsToDisplay [
	^ #(#add: #addAll: #intersection: #remove: #removeAll #removeAll: #removeAllSuchThat: #union:)
]
