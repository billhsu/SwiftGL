//
//  Vao.swift
//  SwiftGL
//
//  Created by Scott Bennett on 2014-06-09.
//  Copyright (c) 2014 Scott Bennett. All rights reserved.
//

import Foundation

class Vao {
    var id: GLuint
    
    init() {
        id = 0
        glGenVertexArrays(1, &id)
    }
    
    deinit {
        glDeleteVertexArrays(1, &id)
    }
    
    func bind() {
        glBindVertexArray(id);
    }
}

protocol GLType {
    class var glType: GLenum {get}
    class var glNormalized: GLboolean {get}
    class var glSize: GLint {get}
}

extension CFloat: GLType {
    static var glType: GLenum {get {return GLenum(GL_FLOAT)}}
    static var glNormalized: GLboolean {get {return GLboolean(GL_FALSE)}}
    static var glSize: GLint {get {return 1}}
}

extension Vec2: GLType {
    static var glType: GLenum {get {return GLenum(GL_FLOAT)}}
    static var glNormalized: GLboolean {get {return GLboolean(GL_FALSE)}}
    static var glSize: GLint {get {return 2}}
}

extension Vec3: GLType {
    static var glType: GLenum {get {return GLenum(GL_FLOAT)}}
    static var glNormalized: GLboolean {get {return GLboolean(GL_FALSE)}}
    static var glSize: GLint {get {return 3}}
}

extension Vec4: GLType {
    static var glType: GLenum {get {return GLenum(GL_FLOAT)}}
    static var glNormalized: GLboolean {get {return GLboolean(GL_FALSE)}}
    static var glSize: GLint {get {return 4}}
}

extension Vao {
    func bind <T: GLType> (#attribute: GLuint, type: T.Type, vbo: Vbo, offset: GLsizeiptr) {
        glBindVertexArray(id)
        glEnableVertexAttribArray(attribute)
        
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vbo.id)
        glVertexAttribPointer(attribute, type.glSize, type.glType, type.glNormalized, GLsizei(vbo.stride), COffsetPtr(offset))
    }
}

extension Vao {
    func bindElements(vbo: Vbo) {
        glBindVertexArray(id)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), vbo.id)
    }
}
