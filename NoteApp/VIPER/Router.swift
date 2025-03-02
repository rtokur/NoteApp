//
//  Router.swift
//  NoteApp
//
//  Created by Rumeysa Tokur on 2.03.2025.
//

import Foundation
import UIKit
//Protocol
//Entry point

typealias EntryPoint = AnyView & UIViewController

//MARK: Protocol
protocol AnyRouter {
    var entry: EntryPoint? { get }
    static func start() -> AnyRouter
}

class UserNotesRouter: AnyRouter {
    //MARK: Property
    var entry: EntryPoint?
    
    //MARK: Method
    static func start() -> any AnyRouter {
        let router = UserNotesRouter()
        
        //Assign VIP
        var presenter : AnyPresenter = UserNotesPresenter()
        var view: AnyView = UserNotesViewController()
        var interactor : AnyInteractor = UserNotesInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
