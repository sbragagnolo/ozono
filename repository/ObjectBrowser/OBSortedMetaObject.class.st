"
I am the meta-object that represents an (sub)instance of sorted collection.

I provide reflective access to the object to treat it as it is inside a prototipical system:

- attributes (instance variables)
- methods
- cloning

I also provide some information of the actions that can be performed on me that is for usage of the UI.
"
Class {
	#name : #OBSortedMetaObject,
	#superclass : #OBCollectionMetaObject,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #methods }
OBSortedMetaObject >> selectorsToDispay [
	^ super selectorsToDispay , #(#add: #addAll: #allButLast #at: #at:put: #beginsWith: #copyFrom:to: #first #first: #gather: #includes: #indexOf: #inject:into: #intersection: #last #last: #remove: #removeAll #removeAll: #removeAllSuchThat: #union:)
]
