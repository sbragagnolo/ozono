Class {
	#name : #OBBindingsV2AndBelow,
	#superclass : #Object,
	#instVars : [
		'LOOPLesson',
		'ObjectBrowserObject',
		'NoObjectBrowserObject',
		'ObjectBrowserCollection',
		'set',
		'dictionary',
		'ordered',
		'bag',
		'sorted'
	],
	#category : #'ObjectBrowser-Filein'
}

{ #category : #'initialize-release' }
OBBindingsV2AndBelow >> initialize [

	super initialize.
	LOOPLesson := OBLessonV2.
	ObjectBrowserObject := OBMetaObjectV2.
	NoObjectBrowserObject := OBMetaNoObjectV2.
	ObjectBrowserCollection := OBMetaCollectionV2.
	set := OBCollectionPrototypeV2 for: Set.
	dictionary := OBCollectionPrototypeV2 for: Dictionary.
	ordered := OBCollectionPrototypeV2 for: OrderedCollection.
	bag := OBCollectionPrototypeV2 for: Bag.
	sorted := OBCollectionPrototypeV2 for: SortedCollection.
]
