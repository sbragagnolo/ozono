"
I am the meta-object that represents an (sub)instance of bag.

I provide reflective access to the object to treat it as it is inside a prototipical system:

- attributes (instance variables)
- methods
- cloning

I also provide some information of the actions that can be performed on me that is for usage of the UI.
"
Class {
	#name : #OBBagMetaObject,
	#superclass : #OBCollectionMetaObject,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #methods }
OBBagMetaObject >> classSelectorsToDisplay [
	^ super classSelectorsToDisplay , #(#add: #addAll: #intersection: #remove: #removeAll #removeAll: #removeAllSuchThat: #union:)
]
