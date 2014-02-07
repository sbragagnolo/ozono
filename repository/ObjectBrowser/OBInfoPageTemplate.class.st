Class {
	#name : #OBInfoPageTemplate,
	#superclass : #OBCommonPageTemplate,
	#category : #'ObjectBrowser-PDFGeneration'
}

{ #category : #'as yet unclassified' }
OBInfoPageTemplate >> createContent. [
	self createHeading: 'Información Adicional' withHeight:15 onTop: 0.
	self createLabel: 'Sistema Operativo:' withText: lessonToPDF operatingSystem withHeight: 15 onTop: 20.
	self createLabel: 'Fecha y Hora:' withText: lessonToPDF date asString withHeight: 15 onTop: 35.
	self createLabel: 'Pharo:' withText: lessonToPDF pharoVersion withHeight: 15 onTop: 50.
	self createLabel: 'Ozono:' withText: lessonToPDF ozonoVersion withHeight: 15 onTop: 65.
	self createLabel: 'VM:' withText: lessonToPDF vmVersion withHeight: 80 onTop: 80.

]
