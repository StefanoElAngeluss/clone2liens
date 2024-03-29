// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from './application'

import CommentairesController from './commentaires_controller'
application.register('commentaires', CommentairesController)

import DragController from './drag_controller'
application.register('drag', DragController)

import DropzoneController from './dropzone_controller'
application.register('dropzone', DropzoneController)

import EmojiPickerController from './emoji_picker_controller'
application.register('emoji-picker', EmojiPickerController)

import HelloController from './hello_controller'
application.register('hello', HelloController)

import ThreejsController from './threejs_controller'
application.register('threejs', ThreejsController)
