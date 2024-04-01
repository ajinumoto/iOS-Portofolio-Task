//
//  QRScannerViewController.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import UIKit
import AVFoundation

class QRScannerViewController: UIViewController, QRScannerPresenterToViewProtocol {
    var presenter: QRScannerViewToPresenterProtocol?
    
    private var avSession = AVCaptureSession()
    private var avPreview = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pindai QRIS"
        
        view.backgroundColor = .white
        
        guard let avDevice = AVCaptureDevice.default(for: .video) else {
            showAlert(message: "Tidak dapat mendeteksi kamera")
            return
        }
        
        do {
            let avInput = try AVCaptureDeviceInput(device: avDevice)
            avSession.addInput(avInput)
        } catch {
            print(error.localizedDescription)
        }
        
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        
        let squareSize: CGFloat = min(screenWidth, screenHeight) * 0.8
        
        let avPreviewX = (screenWidth - squareSize) / 2
        let avPreviewY = (screenHeight - squareSize) / 2
        
        let cameraRect = CGRect(x: avPreviewX, y: avPreviewY, width: squareSize, height: squareSize)
        
        let avOutput = AVCaptureMetadataOutput()
        avSession.addOutput(avOutput)
        
        avOutput.setMetadataObjectsDelegate(self, queue: .main)
        avOutput.metadataObjectTypes = [.qr]
        
        let normalizedRect = CGRect(x: cameraRect.origin.y / screenHeight,
                                    y: cameraRect.origin.x / screenWidth,
                                    width: cameraRect.height / screenHeight,
                                    height: cameraRect.width / screenWidth)
        avOutput.rectOfInterest = normalizedRect
        
        let avPreview = AVCaptureVideoPreviewLayer(session: avSession)
        avPreview.videoGravity = .resizeAspectFill
        avPreview.frame = cameraRect
        view.layer.addSublayer(avPreview)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.avSession.startRunning()
        }
    }
    
    override func loadView() {
        super.loadView()
    }
    
    func showAlert(message: String){
        let controller = UIAlertController(
            title: "Terjadi Kesalahan",
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }
        )
        
        controller.addAction(action)
        
        present(controller, animated: true, completion: nil)
    }
    
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        defer {
            output.setMetadataObjectsDelegate(nil, queue: nil)
            DispatchQueue.global(qos: .userInitiated).async {
                self.avSession.stopRunning()
            }
        }
        
        guard let metadata = metadataObjects.first,
              let readableCode = metadata as? AVMetadataMachineReadableCodeObject,
              let stringData = readableCode.stringValue else {
            showAlert(message: "Tidak dapat mengaktifkan fitur pindai QR")
            return
        }
        
        let qrisData = stringData.components(separatedBy: ".")
        
        guard let bankName = qrisData[safe: 0],
              let transactionID = qrisData[safe: 1],
              let merchantName = qrisData[safe: 2],
              let amountString = qrisData[safe: 3],
              let amountValue = Int(amountString) else {
            showAlert(message: "Format QRIS Salah")
            return
        }
        
        let qris = QRISModel(bankName: bankName, transactionID: transactionID, merchantName: merchantName, amountValue: amountValue)
        
        
        let paymentView = PaymentRouter.createModule(qris)
        navigationController?.pushViewController(paymentView, animated: true)
        
    }
    
}
