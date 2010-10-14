Class {
	#name : #TestsOrganization,
	#superclass : #Object,
	#instVars : [
		'objectBrowser'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
TestsOrganization class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself
]

{ #category : #'as yet unclassified' }
TestsOrganization >> asString [
	^'Tests'
]

{ #category : #'as yet unclassified' }
TestsOrganization >> icon [
	^ObjectBrowserIcons testsIcon
]

{ #category : #'as yet unclassified' }
TestsOrganization >> makeSelectionOn: anObjectBrowser [ 
	anObjectBrowser testsOrganizationSelected
]

{ #category : #'as yet unclassified' }
TestsOrganization >> menu: aMenuBuilder [
	^aMenuBuilder addList: (OrderedCollection with: #('crear nuevo test' #createTest))
]

{ #category : #'as yet unclassified' }
TestsOrganization >> objectBrowser: anObjectBrowser [
	objectBrowser := anObjectBrowser
]

{ #category : #'as yet unclassified' }
TestsOrganization >> treeContents [ 
	^objectBrowser tests
]
