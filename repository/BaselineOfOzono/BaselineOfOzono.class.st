Class {
	#name : #BaselineOfOzono,
	#superclass : #BaselineOf,
	#category : #BaselineOfOzono
}

{ #category : #baselines }
BaselineOfOzono >> artefact: spec [
	spec
    	baseline: 'Artefact'
    	with: [ spec repository: 'github://pharo-contributions/Artefact:master/src' ]
]

{ #category : #baselines }
BaselineOfOzono >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self smallUml: spec.
			self artefact: spec.
			spec
				package: 'ObjectBrowser'
				with: [ spec requires: #('SmallUml' 'Artefact') ].
			spec group: 'default' with: #('ObjectBrowser') ]
]

{ #category : #baselines }
BaselineOfOzono >> smallUml: spec [
	spec
    	baseline: 'SmallUml'
    	with: [ spec repository: 'github://sbragagnolo/SmallUml/repository' ]
]
