Class {
	#name : #ObjectMenuCategory,
	#superclass : #Object,
	#category : #'ObjectBrowser-ControlPanel'
}

{ #category : #'as yet unclassified' }
ObjectMenuCategory class >> menuCommandOn: aBuilder [  
	<worldMenu>
	(aBuilder item: #'Object Browser')
		order: 5.5;
		target: self;
		icon: UITheme current homeIcon
]
