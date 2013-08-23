"
I am in charge of evaluating the expressions inside the execution context.

I delegate to the context to prepare and commit the changes after execution.
"
Class {
	#name : #LOOPEvaluator,
	#superclass : #Object,
	#category : #'ObjectBrowser-Lessons'
}

{ #category : #'public access' }
LOOPEvaluator >> evaluate: textOrStream in: aContext to: receiver notifying: aRequestor ifFail: failBlock logged: logFlag [

	receiver prepare.
	^ErrorHandler evaluate:  [[
			Compiler new
		evaluate: textOrStream 
		in: aContext 
		to: receiver 
		notifying: aRequestor 
		ifFail: failBlock 
		logged: logFlag.]
	ensure:[receiver commitChanges. ]]
]
