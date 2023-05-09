//
//  ViewController.swift
//  ExAVPlayer
//
//  Created by Jake.K on 2022/04/28.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
  private let stackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.spacing = 16.0
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private let label: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let playerView = MyPlayerView()
  private let audioRecoderView = MyAudioRecoderView()
  private let audioPlayerView = MyAudioPlayerView()
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    self.view.addSubview(self.stackView)
    self.view.addSubview(self.label)
    self.stackView.addArrangedSubview(self.playerView)
    self.stackView.addArrangedSubview(self.audioRecoderView)
    self.stackView.addArrangedSubview(self.audioPlayerView)
    
    NSLayoutConstraint.activate([
      self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    NSLayoutConstraint.activate([
      self.label.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      self.label.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      self.label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
    ])
    
    self.playerView.url = URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3")!
    self.playerView.isHidden = true
    
    self.audioRecoderView.stopSubject
      .bind { [weak self] in
        print("값 \($0)")
        self?.audioPlayerView.url = $0
        self?.audioPlayerView.readyToPlay = true
      }
      .disposed(by: self.disposeBag)
  }
}
