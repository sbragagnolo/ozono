Class {
	#name : #PdepDiagrams,
	#superclass : #DiagramsHolder,
	#category : #'ObjectBrowser-Diagrams'
}

{ #category : #'as yet unclassified' }
PdepDiagrams class >> icon [
	^Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self iconContents readStream).
]

{ #category : #'as yet unclassified' }
PdepDiagrams class >> iconContents [ 
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
