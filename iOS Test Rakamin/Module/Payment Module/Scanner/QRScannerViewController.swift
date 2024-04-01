//
//  QRScannerViewController.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import UIKit
import AVFoundation

// MARK: - View Controller
class QRScannerViewController: UIViewController, QRScannerPresenterToViewProtocol {
    var presenter: QRScannerViewToPresenterProtocol?

    private var avSession = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startQRScanning()
    }

    private func setupUI() {
        self.title = "Pindai QRIS"
        view.backgroundColor = .white
    }

    private func startQRScanning() {
        guard let avDevice = AVCaptureDevice.default(for: .video) else {
            showAlert(message: "Tidak dapat mendeteksi kamera")
            return
        }

        do {
            let avInput = try AVCaptureDeviceInput(device: avDevice)
            avSession.addInput(avInput)
        } catch {
            print(error.localizedDescription)
            showAlert(message: "Tidak dapat mengaktifkan kamera")
            return
        }

        let avOutput = AVCaptureMetadataOutput()
        avSession.addOutput(avOutput)

        avOutput.setMetadataObjectsDelegate(self, queue: .main)
        avOutput.metadataObjectTypes = [.qr]

        let avPreview = AVCaptureVideoPreviewLayer(session: avSession)
        avPreview.videoGravity = .resizeAspectFill
        avPreview.frame = view.layer.bounds
        view.layer.addSublayer(avPreview)

        DispatchQueue.global(qos: .userInitiated).async {
            self.avSession.startRunning()
        }
    }

    func showAlert(message: String) {
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

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
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
