//
//  MyAudioRecoderView.swift
//  ExAVPlayer
//
//  Created by Jake.K on 2022/04/29.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

final class MyAudioRecoderView: UIView {
  private let label: UILabel = {
    let label = UILabel()
    label.text = "AVAudioRecoder"
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  private let button: UIButton = {
    let button = UIButton()
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitleColor(.blue, for: .highlighted)
    button.setTitle("녹음시작", for: .normal)
    button.setTitle("중지", for: .selected)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  let stopSubject = PublishSubject<URL>()
  var url: URL {
    return self.audioRecorder.url
  }
  
  private var audioRecorder = AVAudioRecorder()
  private let disposeBag = DisposeBag()
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(self.label)
    self.addSubview(self.button)
    
    NSLayoutConstraint.activate([
      self.label.leftAnchor.constraint(equalTo: self.leftAnchor),
      self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.label.topAnchor.constraint(equalTo: self.topAnchor),
    ])
    NSLayoutConstraint.activate([
      self.button.leftAnchor.constraint(equalTo: self.label.rightAnchor, constant: 16),
      self.button.rightAnchor.constraint(equalTo: self.rightAnchor),
      self.button.centerYAnchor.constraint(equalTo: self.label.centerYAnchor)
    ])
    
    Observable<Int>
      .interval(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
      .compactMap { [weak self] _ in self?.audioRecorder.currentTime }
      .bind { print("경과 시간: \($0)") }
      .disposed(by: self.disposeBag)
    
    self.button.rx.isHighlighted
      .filter { $0 == true }
      .withLatestFrom(self.button.rx.isSelected)
      .map { !$0 }
      .do { [weak self] in $0 ? self?.record() : self?.stop() }
      .bind(to: self.button.rx.isSelected)
      .disposed(by: self.disposeBag)
  }
  
  func record() {
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
      .appendingPathComponent("myRecoding.m4a")
    let settings = [
      AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
      AVSampleRateKey: 12000,
      AVNumberOfChannelsKey: 1,
      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    
    do {
      try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
    } catch {
      print("audioSession error: \(error.localizedDescription)")
    }
    
    do {
      self.audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
      self.audioRecorder.delegate = self
      self.audioRecorder.record()
    } catch {
      print("occured error in MyAudioRecoderView = \(error.localizedDescription)")
      self.stop()
    }
  }
  func stop() {
    self.audioRecorder.stop()
    self.stopSubject.onNext(self.url)
  }
}

extension MyAudioRecoderView: AVAudioRecorderDelegate {
  func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
    self.stop()
  }
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    self.stop()
  }
}
