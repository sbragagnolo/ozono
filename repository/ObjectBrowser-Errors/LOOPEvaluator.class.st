Class {
	#name : #LOOPEvaluator,
	#superclass : #Compiler,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
LOOPEvaluator >> evaluate: textOrStream in: aContext to: receiver notifying: aRequestor ifFail: failBlock logged: logFlag [

	receiver prepare.
	[^ super 
		evaluate: textOrStream 
		in: aContext 
		to: receiver 
		notifying: aRequestor 
		ifFail: failBlock 
		logged: logFlag.]
	ensure:[receiver commitChanges.]
]
