Class {
	#name : #ObjectMenuCategory,
	#superclass : #Object,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectMenuCategory class >> menuCommandOn: aBuilder [  
	<worldMenu>
	(aBuilder item: #'PdeP Software')
		order: 5.5;
		target: self;
		icon: UITheme current homeIcon.
]
