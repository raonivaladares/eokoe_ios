import Foundation

protocol Injectable {
  associatedtype T
  func inject(value: T)
}
