Class {
	#name : #LOOPBrowser,
	#superclass : #Object,
	#instVars : [
		'lessonContainer',
		'window',
		'selectedLesson'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
LOOPBrowser class >> icon [
	^Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self iconContents readStream).
]

{ #category : #'as yet unclassified' }
LOOPBrowser class >> iconContents [
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAFo9M/3AAAAAXNSR0IArs4c6QAAAAZiS0dE
AP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9oIFQQZHdfJFJgAAAJV
SURBVDjLrZJJSNQBFMZ//5k/hS1jo5ZK4KEsKrIMQQxPNm3HpMWihXI61EGCaqTCoghpQ8Eg
IgwyU5KKjAgtIgtKyoIypjShxRIbJ5tySWdxnK+DmZRFl77Le3x8b3+GJAAsAIt2X5AxzJgo
rLxD5SCJ3AuPJUkFZ2plAny5X0dVVDcZ8X5+xgzDMmSkR+43AjDXHL6sIFb0uZ3rJXlYLu1f
bRgeD8HOXoBfc5TefaWgP8DyuYkkJ8UbP7KJ7aV18no8GrvlnCZtLtXx8hpNduRLEiZApj3E
gdKbzA97aTi/i8HQALU1jaNL/An/FJjDzssPn3WnycN4YxDnslTjp0ISW8vqdfv5Ww3DeaJa
kpA0JLDmlKjo4i3ZnGWyrT0pSTpw6vrIFOvnTaHtUx+OpAm0e4Io2I+/+9tIDy2tX7l6cCV3
GppJzZ5D/rFKFsyIGxEcXpHEhn0VmJEA9QkT6O3qYcemJf9pD/+C+Tuxr/qZ7LbxpMSOITbK
xJDo7gvw9J2PsN/P3o1Zxh8eCF687ZCxuUwJ1gAux0w8ng6OVD+m8MpDXr//iGtVBlNtVmyO
ArW2eTVqhExXpSLhfh4U5rCu6AZuXwRfVx+R0ADWyCCJpp/Gij0sdR4jJjqaquJtxi8dZE6L
wTIgekLgyk5niiXM3LgoHNPGsXj6RApzs/B1dqKwSE1OGL2DnDQ7ze5mVrjK8Qf6mZ0UQ9HO
lcTF2vF6Ozl6+hrFZ+tIiIaFsyb+/QotL9y619DEk6YOfF/9SBEm28aQnjKVjLSZpCxIM/7r
Gb8DeEs6z/3CU5IAAAAASUVORK5CYII='
]

{ #category : #'as yet unclassified' }
LOOPBrowser class >> menuCommandOn: aBuilder [ 
	<worldMenu>
	(aBuilder item: #'Loop Browser')
		parent: #MostUsedTools;  
		action: [LOOPLesson browseLessons];
		icon: self icon.
]

{ #category : #'as yet unclassified' }
LOOPBrowser class >> on: aLOOPLessonContainer [
	^self new lessonContainer: aLOOPLessonContainer;
		yourself.
]

{ #category : #creation }
LOOPBrowser >> createFreeLesson [
	| lesson |
	lesson := lessonContainer createFreeLesson.
	lesson openInWorld.

]

{ #category : #creation }
LOOPBrowser >> createNewFreeLesson [
	| lesson |
	lesson := lessonContainer createLessonNamed: self obtainLessonName.
	lesson openInWorld.
	self changed .
]

{ #category : #accessing }
LOOPBrowser >> fileOutSelectedLesson [
	self selectedLesson fileOut 
]

{ #category : #accessing }
LOOPBrowser >> initialize [
	self selectedLesson: NullLOOPLesson new.
]

{ #category : #creation }
LOOPBrowser >> lessonContainer: aLessonContainer [
	lessonContainer := aLessonContainer
]

{ #category : #showing }
LOOPBrowser >> lessonListMenu: aMenu shifted: shifted [
	^aMenu addList: self selectedLesson menuActions.
]

{ #category : #creation }
LOOPBrowser >> lessons [
	^lessonContainer lessons
]

{ #category : #accessing }
LOOPBrowser >> newFreeLessonLabel [
	^'New Free Lesson'
]

{ #category : #creation }
LOOPBrowser >> obtainLessonName [
	| lessonName |
	lessonName := self request: 'Nombre de la leccion' default: 'Free Lesson'.
	^ lessonName
]

{ #category : #showing }
LOOPBrowser >> openInWorld [
	window := LOOPWindow show: self.
]

{ #category : #accessing }
LOOPBrowser >> openSelectedLesson [
	self selectedLesson openInWorld
]

{ #category : #accessing }
LOOPBrowser >> removeSelectedLesson [
	| lesson |
	lesson := self selectedLesson.
	lesson delete.
	self lessons remove: lesson.
	lesson clean.
	self changed.
]

{ #category : #creation }
LOOPBrowser >> request: aTitle default: aDefaultValue [
	^ UIManager default
		request: aTitle
		initialAnswer: aDefaultValue
]

{ #category : #accessing }
LOOPBrowser >> selectedLesson [
	^selectedLesson
]

{ #category : #accessing }
LOOPBrowser >> selectedLesson: aLOOPLesson [ 
	selectedLesson := aLOOPLesson.
]
