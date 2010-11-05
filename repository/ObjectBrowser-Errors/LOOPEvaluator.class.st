Class {
	#name : #LOOPEvaluator,
	#superclass : #Compiler,
	#category : #'ObjectBrowser-Lessons'
}

{ #category : #'as yet unclassified' }
LOOPEvaluator >> evaluate: textOrStream in: aContext to: receiver notifying: aRequestor ifFail: failBlock logged: logFlag [

	receiver prepare.
	ErrorHandler evaluate:  [[^ super 
		evaluate: textOrStream 
		in: aContext 
		to: receiver 
		notifying: aRequestor 
		ifFail: failBlock 
		logged: logFlag.]
	ensure:[receiver commitChanges. ]]
]
