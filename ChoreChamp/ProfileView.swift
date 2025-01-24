import PhotosUI
import Supabase
import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    @State var email = ""
    @State var displayName = ""
    @State var rating = ""

    @State var isLoading = false

    @State var imageSelection: PhotosPickerItem?
    @State var profilePicture: ProfilePicture?

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Group {
                            if let profilePicture {
                                profilePicture.image.resizable()
                            } else {
                                Color.clear
                            }
                        }
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        
                        Spacer()
                        
                        PhotosPicker(selection: $imageSelection, matching: .images) {
                            Image(systemName: "pencil.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 30))
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                
                Section {
                    TextField("Display Name", text: $displayName)
                        .textContentType(.username)
#if os(iOS)
                        .textInputAutocapitalization(.never)
#endif
                    TextField("Email", text: $email)
                        .textContentType(.name)
                    TextField("Website", text: $rating)
                        .textContentType(.URL)
#if os(iOS)
                        .textInputAutocapitalization(.never)
#endif
                }
                
                Section {
                    Button("Update profile") {
//                        updateProfileButtonTapped()
                    }
                    .bold()
                    
                    if isLoading {
                        ProgressView()
                    }
                }
            }
            .navigationTitle("Profile")
            .toolbar(content: {
                ToolbarItem {
                    Button("Sign out", role: .destructive) {
                        Task {
                            try? await viewModel.signOut()
                        }
                    }
                }
            })
            .onChange(of: imageSelection) { _, newValue in
                guard let newValue else { return }
//                loadTransferable(from: newValue)
            }
        }
        .task {
            try? await viewModel.fetchUserInfoRequests()
        }
    }
//
//    func updateProfileButtonTapped() {
//    Task {
//      isLoading = true
//      defer { isLoading = false }
//      do {
//        let imageURL = try await uploadImage()
//
//        let currentUser = try await supabase.auth.session.user
//
//        let updatedUser = User(
//          username: username,
//          fullName: fullName,
//          website: website,
//          avatarURL: imageURL
//        )
//
//        try await supabase.database
//          .from("profiles")
//          .update(updatedProfile)
//          .eq("id", value: currentUser.id)
//          .execute()
//      } catch {
//        debugPrint(error)
//      }
//    }
//    }
//
//    private func loadTransferable(from imageSelection: PhotosPickerItem) {
//    Task {
//      do {
//        avatarImage = try await imageSelection.loadTransferable(type: AvatarImage.self)
//      } catch {
//        debugPrint(error)
//      }
//    }
//    }
//
//    private func downloadImage(path: String) async throws {
//    let data = try await supabase.storage.from("avatars").download(path: path)
//    avatarImage = AvatarImage(data: data)
//    }
//
//    private func uploadImage() async throws -> String? {
//    guard let data = avatarImage?.data else { return nil }
//
//    let filePath = "\(UUID().uuidString).jpeg"
//
//    try await supabase.storage
//      .from("avatars")
//      .upload(
//        path: filePath,
//        file: data,
//        options: FileOptions(contentType: "image/jpeg")
//      )
//
//    return filePath
//    }
    }

//    #if swift(>=5.9)
//    #Preview {
//    ProfileView()
//    }
//    #endif
