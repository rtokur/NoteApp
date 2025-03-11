//
//  Presenter.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 2.03.2025.
//

import Foundation
//Object
//Protocol
//reference to interactor, view, router

//MARK: Protocol
protocol AnyPresenter {
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    var router: AnyRouter? { get set }
    
    func interactorDidFetch(with result: Result<[UserNotes],
                            Error>)
    func userNotLogin()
}

class UserNotesPresenter: AnyPresenter {
    
    //MARK: Properties
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getNotes()
        }
    }
    
    var view: AnyView?
    
    var router: AnyRouter?

    //MARK: Methods
    func interactorDidFetch(with result: Result<[UserNotes],
                            any Error>) {
        switch result {
        case .success(let notes):
            view?.updateNotes(with: notes)
        case .failure(let error):
            view?.updateNotes(with: error.localizedDescription)
        }
    }
    
    func userNotLogin() {
        view?.userNotLogin()
    }

    
    
}
