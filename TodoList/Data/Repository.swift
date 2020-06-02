//
//  Repository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol Repository {

  associatedtype Item

  func getAll() -> [Item]
  //func add(item: Item) -> Bool
}
