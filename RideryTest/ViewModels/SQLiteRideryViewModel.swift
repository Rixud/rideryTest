//
//  SQLiteRideryViewModel.swift
//  RideryTest
//
//  Created by Luis Guerra on 15/6/23.
//

import Foundation
import SQLite

class SQLiteRideryViewModel {
    
    let users = Table("users")
    let id = Expression<Int64>("id")
    let email = Expression<String>("email")
    let phoneNumber = Expression<String>("phone")
    
    private var db: Connection? = nil
    
    func createDatabase() -> Connection? {
        do {
            let directory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = directory.appendingPathComponent("user").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            return database
        }catch{
            print(error)
        }
        return nil
    }
    
    func createTable() {
        do {
            if db == nil {
                db = createDatabase()
            }
            try db?.run(users.create {t in
                t.column(id, primaryKey: true)
                t.column(email, unique: true)
                t.column(phoneNumber)
            })
        } catch {
            print(error)
        }
    }
    
    func addUser(phone:String, mail:String) -> Int64? {
        do {
            let inser = users.insert(phoneNumber <- phone, email <- mail)
            let rowId = try db?.run(inser)
            return rowId
        }catch {
            print(error)
        }
        return nil
    }
    
    func checkDatabase(){
        do {
            for user in try db!.prepare(users) {
                print("id: \(user[id]), email: \(user[email]),phone: \(user[phoneNumber]) ")
            }
        }catch {
            print(error)
        }
    }
    
    
    func editEmail(rowId:Int64, newEmail:String) {
        do {
            let editUser = users.filter(id == rowId)
            try db?.run(editUser.update(email <- email.replace("", with: newEmail)))
        }catch {
            print(error)
        }
    }

}
