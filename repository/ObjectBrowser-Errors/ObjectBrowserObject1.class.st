Class {
	#name : #ObjectBrowserObject1,
	#superclass : #ObjectBrowserClass,
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'object browser' }
ObjectBrowserObject1 >> sueldo [
	^5000
]

{ #category : #'object browser' }
ObjectBrowserObject1 >> sueldo: unNumero [
	^5000 * unNumero
]
