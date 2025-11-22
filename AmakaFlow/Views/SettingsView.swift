//
//  SettingsView.swift
//  AmakaFlow
//
//  Settings screen with account and preferences
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var showingSignOutAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.Colors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: Theme.Spacing.lg) {
                        // Account Section
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            Text("Account")
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.textSecondary)
                                .textCase(.uppercase)
                                .padding(.horizontal, Theme.Spacing.lg)
                            
                            VStack(spacing: 0) {
                                SettingRow(
                                    icon: "person.circle.fill",
                                    title: "Profile",
                                    subtitle: "athlete@amakaflow.com"
                                ) {}
                                
                                Divider()
                                    .background(Theme.Colors.borderLight)
                                    .padding(.leading, 56)
                                
                                SettingRow(
                                    icon: "bell.fill",
                                    title: "Notifications",
                                    subtitle: "Workout reminders",
                                    toggle: $notificationsEnabled
                                ) {}
                            }
                            .background(Theme.Colors.surface)
                            .overlay(
                                RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                                    .stroke(Theme.Colors.borderLight, lineWidth: 1)
                            )
                            .cornerRadius(Theme.CornerRadius.xl)
                            .padding(.horizontal, Theme.Spacing.lg)
                        }
                        
                        // Connected Services
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            Text("Connected Services")
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.textSecondary)
                                .textCase(.uppercase)
                                .padding(.horizontal, Theme.Spacing.lg)
                            
                            VStack(spacing: 0) {
                                SettingRow(
                                    icon: "applewatch",
                                    title: "Apple Watch",
                                    subtitle: "Connected",
                                    iconColor: Theme.Colors.accentBlue
                                ) {}
                                
                                Divider()
                                    .background(Theme.Colors.borderLight)
                                    .padding(.leading, 56)
                                
                                SettingRow(
                                    icon: "calendar",
                                    title: "Apple Calendar",
                                    subtitle: "Authorized",
                                    iconColor: Theme.Colors.accentGreen
                                ) {}
                            }
                            .background(Theme.Colors.surface)
                            .overlay(
                                RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                                    .stroke(Theme.Colors.borderLight, lineWidth: 1)
                            )
                            .cornerRadius(Theme.CornerRadius.xl)
                            .padding(.horizontal, Theme.Spacing.lg)
                        }
                        
                        // About
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            Text("About")
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.textSecondary)
                                .textCase(.uppercase)
                                .padding(.horizontal, Theme.Spacing.lg)
                            
                            VStack(spacing: 0) {
                                SettingRow(
                                    icon: "info.circle.fill",
                                    title: "Version",
                                    subtitle: "1.0.0",
                                    showChevron: false
                                ) {}
                                
                                Divider()
                                    .background(Theme.Colors.borderLight)
                                    .padding(.leading, 56)
                                
                                SettingRow(
                                    icon: "doc.text.fill",
                                    title: "Terms of Service",
                                    showChevron: true
                                ) {}
                                
                                Divider()
                                    .background(Theme.Colors.borderLight)
                                    .padding(.leading, 56)
                                
                                SettingRow(
                                    icon: "hand.raised.fill",
                                    title: "Privacy Policy",
                                    showChevron: true
                                ) {}
                            }
                            .background(Theme.Colors.surface)
                            .overlay(
                                RoundedRectangle(cornerRadius: Theme.CornerRadius.xl)
                                    .stroke(Theme.Colors.borderLight, lineWidth: 1)
                            )
                            .cornerRadius(Theme.CornerRadius.xl)
                            .padding(.horizontal, Theme.Spacing.lg)
                        }
                        
                        // Sign Out
                        Button(action: {
                            showingSignOutAlert = true
                        }) {
                            Text("Sign Out")
                                .font(Theme.Typography.bodyBold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(Theme.Colors.accentRed)
                                .cornerRadius(Theme.CornerRadius.md)
                        }
                        .padding(.horizontal, Theme.Spacing.lg)
                        .padding(.top, Theme.Spacing.md)
                        .padding(.bottom, Theme.Spacing.lg)
                    }
                    .padding(.top, Theme.Spacing.md)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .alert("Sign Out", isPresented: $showingSignOutAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Sign Out", role: .destructive) {
                    // Handle sign out
                    print("User signed out")
                }
            } message: {
                Text("Are you sure you want to sign out?")
            }
        }
    }
}

// MARK: - Setting Row
struct SettingRow: View {
    let icon: String
    let title: String
    var subtitle: String? = nil
    var iconColor: Color = Theme.Colors.textSecondary
    var showChevron: Bool = false
    var toggle: Binding<Bool>? = nil
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Theme.Spacing.md) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(iconColor)
                    .frame(width: 24, height: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(Theme.Typography.body)
                        .foregroundColor(Theme.Colors.textPrimary)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(Theme.Typography.caption)
                            .foregroundColor(Theme.Colors.textSecondary)
                    }
                }
                
                Spacer()
                
                if let toggle = toggle {
                    Toggle("", isOn: toggle)
                        .labelsHidden()
                        .tint(Theme.Colors.accentBlue)
                } else if showChevron {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundColor(Theme.Colors.textSecondary)
                }
            }
            .padding(.horizontal, Theme.Spacing.lg)
            .padding(.vertical, Theme.Spacing.md)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SettingsView()
        .preferredColorScheme(.dark)
}
